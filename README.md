# fake-csv

Create fake CSV data

Install gems with `bundle install`

Update `template.yml` with fake CSV definition

Run `ruby fake_csv.rb` to produce the output file `fake.csv`

## Supported Data

### name

Generates a first and last name separated by a space

```
- name: name
  type: name
```

### integer

Generates an integer between min and max values

```
- name: age
  type: integer
  options:
    min: 18
    max: 100
```

### date

Generates a date between min and max values

```
- name: dob
  type: date
  options:
    min: 1930-01-01
    max: 2020-01-01
```

### postcode

Generates a UK style postcode

### id

Generates an ID in the style of US SSN, e.g `552-56-3593`

```
- name: patient_id
  type: id
```

### enum

Selects a value from a supplied list.  Values can be weighted

```
- name: gender
  type: enum
  options:
    list:
    - m
    - f
- name: ethnicity
  type: enum
  options:
    list:
    - value: white
      weight: 70
    - value: black
      weight: 30

```

## Example output

```
name,age,dob,postcode,gender,ethnicity,hospital_id,patient_id
Porter Keebler,61,2014-08-05,H5D 6BB,f,white,hosp5678,422-68-4172
Evelyn Considine,100,2016-11-20,WE4 1EY,f,white,hosp5678,403-39-4811
```


