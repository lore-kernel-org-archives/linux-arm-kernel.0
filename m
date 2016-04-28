From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 28 Apr 2016 11:41:11 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <20160426152337.GA10644@afzalpc>
References: <20160426152337.GA10644@afzalpc>
Message-ID: <5721DAB7.3010202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 04/26/2016 05:23 PM, Afzal Mohammed wrote:
> Hi,
>
> On Tue, Apr 26, 2016 at 09:17:43AM +0100, Vladimir Murzin wrote:
>
>> I built myself, but there are prebild tools available at [1] although
>> I've never tried them.
>>
>> It seems to me there have been internal patches to support FDPIC [2],
>> but I don't know what happen afterwards :(
>>
>> [1] https://launchpad.net/gcc-arm-embedded
>> [2]
>> http://connect.linaro.org/resource/sfo15/sfo15-406-arm-fdpic-toolset-kernel-libraries-for-cortex-m-cortex-r-mmuless-cores/
>>
The ARM FDPIC port is done by Mickael Guene (Added in cc:).
His work is available on github:
  - abi : https://github.com/mickael-guene/fdpic_doc
  - general info : https://github.com/mickael-guene/fdpic_manifest

If you want more details, don't hesitate to contact him.

Regards,
Maxime
