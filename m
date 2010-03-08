From: armando.visconti@st.com (Armando VISCONTI)
Date: Mon, 08 Mar 2010 14:48:50 +0100
Subject: [PATCH 00/11] Adding Support for SPEAr Platform under ARM
	architecture
In-Reply-To: <22dbbef21003070754l6c99f777ycd99cfa892169736@mail.gmail.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<22dbbef21003070754l6c99f777ycd99cfa892169736@mail.gmail.com>
Message-ID: <4B950042.1030007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

We really would like to contribute back to the linux community
with the SPEAr architecture, as we already did for the u-boot loader.

We started just adding the minimum required to boot up the system,
but we will definetely add all the remaining peripheral in the
next merging windows.

Can you possibly just spend some times on this patch set and give us
your feedback? We would really appreciate.
:-)


Thx very much,
Armando


viresh kumar wrote:
> Hello Russell,
>
> On Wed, Mar 3, 2010 at 10:37 AM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>   
>> Following set of patches are for adding ST Microelctronics SPEAr Platform under
>> ARM architecture in Linux.
>>
>> Hierarchy in SPEAr is as follows:
>> SPEAr (Platform)
>>        - SPEAr3XX (3XX SOC series, based on ARM9)
>>                - SPEAr300 (SOC)
>>                        - SPEAr300_EVB (Evaluation Board)
>>                - SPEAr310 (SOC)
>>                        - SPEAr310_EVB (Evaluation Board)
>>                - SPEAr320 (SOC)
>>                        - SPEAr320_EVB (Evaluation Board)
>>        - SPEAr6XX (6XX SOC series, based on ARM9)
>>                - SPEAr600 (SOC)
>>                        - SPEAr600_EVB (Evaluation Board)
>>        - SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
>>                - SPEAr1300 (SOC)
>>
>> Current patch will add support for SPEAr3XX and SPEAr6XX family. SPEAr13XX is
>> under development phase.
>>
>>     
>
> Is this patch set fine? Or do i need resubmit it?
>
>
> regards,
> viresh kumar,
> ST Microelectronics
>   
