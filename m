From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 27 May 2011 11:04:19 +0530
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105191550.20129.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>	<alpine.LFD.2.00.1105182234130.14430@xanadu.home>	<BANLkTinXQvrG3LeSEO9Lnam3Bvq3dDKOsw@mail.gmail.com>
	<201105191550.20129.arnd@arndb.de>
Message-ID: <4DDF37DB.40606@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2011 07:20 PM, Arnd Bergmann wrote:
>> > i asked this because we wanted to send the source codes of
>> > CSR(http://www.csr.com) to upstream as i have told you in LDS. it
>> > looks like we need to follow the below new changes to make our source
>> > codes acceptable?
>> > 1. arm device tree
>> > 2. new pinmux framework from Linus Walleij
>> > 3. move GPIO from plat/mach to drivers/gpio?
> I would count at least the last two as mandatory, for the device tree,
> it depends on how much work it would be for you to do the conversion
> and at what time you submit the series. The longer you wait before
> submitting the series, the stricter the requirements will get.
> 

Arnd,

We also have few patchsets for ST's SPEAr SOC family. They were already
reviewed, but never got pushed.

We will update all those pacthsets for point 2 & 3, and leave point 1 for now.
Also we will update them with our latest changes for SPEAr and will circulate
them ASAP.

Hope that's fine.

-- 
viresh
