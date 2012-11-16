From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2012 13:49:57 +0530
Subject: [PATCH 01/16] gpio: SPEAr: add spi chipselect control driver
In-Reply-To: <201211160819.04343.arnd@arndb.de>
References: <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
 <3702a1036f8e714e6d18e4726569bbb1eadd65bf.1353042873.git.viresh.kumar@linaro.org>
 <201211160819.04343.arnd@arndb.de>
Message-ID: <CAKohpoms26Z=1394jubyGY=P=12qzLJSxE-h-K=UL4uQUm22yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2012 13:49, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 16 November 2012, Viresh Kumar wrote:
>> From: Shiraz Hashim <shiraz.hashim@st.com>
>>
>> SPEAr platform provides a provision to control chipselects of ARM PL022
>> Prime Cell spi controller through its system registers, which otherwise
>> remains under PL022 control which some protocols do not want.
>>
>> This commit intends to provide the spi chipselect control in software over
>> gpiolib interface. spi chip drivers can use the exported gpiolib interface to
>> define their chipselect through DT or platform data.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
>> Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

You can apply this series now :)
