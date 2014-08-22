From: ipaton0@gmail.com (Iain Paton)
Date: Fri, 22 Aug 2014 11:36:11 +0100
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <CAOMZO5A3CgaVCKxNDG-zEdwprYdRDXD_XZ2ikW+mns-iieYHsg@mail.gmail.com>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B7FgzB7ThVyV2Vk7wTwYgjRWjEnkkAN5uwwKMaBKq1yg@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
 <53F11FF6.8030303@gmail.com>
 <CAOMZO5CDvQDD7gVLFStwv4MPrUyqZE3sEDZwb0gukkXujYG-6Q@mail.gmail.com>
 <53F2E89B.80009@gmail.com> <53F5BE3D.5070209@gmail.com>
 <CAOMZO5A3CgaVCKxNDG-zEdwprYdRDXD_XZ2ikW+mns-iieYHsg@mail.gmail.com>
Message-ID: <53F71D1B.8090004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/14 01:01, Fabio Estevam wrote:
> On Thu, Aug 21, 2014 at 6:39 AM, Iain Paton <ipaton0@gmail.com> wrote:
> 
>> two and a half days of running this against both a sabre-lite and a
>> wandboard quad B1 and I still have no reason to think there's any
>> sort of a problem.
>>
>> Up to now, my testing has been done with my own config, I'll now
>> repeat the whole thing using the config Mattis posted to see if
>> I can reproduce it that way.
>>
>> Suggestions on a better / easier / quicker way to reproduce it are
>> welcome.
> 
> Thanks, Iain.
> 
> Mattis,
> 
> What is the silicon version of the mx6 in your sabrelite? What GCC
> version do you use?
> 

For reference, both my SL and WBQUAD report silicon rev 1.2
The RIoTboard uses a Solo and reports silicon rev 1.1

I'm using vanilla gcc 4.9.1 and compiling the kernel natively on a 
sabre-lite.
