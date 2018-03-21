From: aford173@gmail.com (Adam Ford)
Date: Wed, 21 Mar 2018 13:41:41 -0500
Subject: WL1837-st on imx6 request_firmware failed with 4.16-RC6
In-Reply-To: <20180321162749.ammvnmamwknwjonr@tarshish>
References: <CAHCN7xKQxF34LSy7TZUQ2yCo9KdrKppOvamgna-CHJD_kt=80w@mail.gmail.com>
 <20180321162749.ammvnmamwknwjonr@tarshish>
Message-ID: <CAHCN7xKN=b5LbsS0ASEO++nLrQ8OQ37znKU9pwifZruu577EDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 11:27 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Adam,
>
> On Wed, Mar 21, 2018 at 10:31:55AM -0500, Adam Ford wrote:
>> I have an i.MX6 board and I am trying to get Bluetooth operational on
>> 4.16-RC6 using the default imx_v6_v7_defconfig
>>
>> I have my device tree configured as follows:
>>
>> &uart2 {
>>   pinctrl-names = "default";
>>   pinctrl-0 = <&pinctrl_uart2>;
>>   uart-has-rtscts;
>>   status = "okay";
>>

[snip]
>
> Is your filesystem mounted at this point? Do you use initramfs?
>
> baruch

That was it.  Thanks.  I feel stupid.  :-)

>
>> I was hoping someone might have some insight on what might be the issue.
>>
>> Thanks
>>
>> adam
>>

[snip]

> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
