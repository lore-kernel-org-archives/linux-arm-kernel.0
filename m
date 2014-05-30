From: todd.fujinaka@intel.com (Fujinaka, Todd)
Date: Fri, 30 May 2014 21:11:46 +0000
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5KdWvc_=m0XZxhb8drjpWVJ68BR_rH9bhrhNerSjCc-Tg@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <20140530191852.GA25314@obsidianresearch.com>
 <CAHH3p5KS9BVb-1-u2LbfLL8OO4pmExGmCtZY=fEYELS+q=grcA@mail.gmail.com>
 <4627439.I2CpBecnJJ@wuerfel>
 <CAHH3p5KdWvc_=m0XZxhb8drjpWVJ68BR_rH9bhrhNerSjCc-Tg@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD653375F6F@ORSMSX114.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It just took me one Google search and I found that VDM is being used for MCTP. Searching the datasheet for the i210 (that I'm sure I suggested you consult) discusses MCTP in section 10.7.

I can't see there is a way to turn off MCTP.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: shiv prakash Agarwal [mailto:chhotu.shiv at gmail.com] 
Sent: Friday, May 30, 2014 1:14 PM
To: Arnd Bergmann
Cc: linux-arm-kernel at lists.infradead.org; Jason Gunthorpe; Duyck, Alexander H; Thomas Petazzoni; e1000-devel at lists.sourceforge.net; Fujinaka, Todd; Lucas Stach
Subject: Re: [E1000-devel] ARM support for igb driver

Notsure about root port, Can't it be disabled by Intel device?

On Sat, May 31, 2014 at 1:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 31 May 2014 01:05:29 shiv prakash Agarwal wrote:
>> Thanks Jason,
>>
>> Is there a way to disable sending VDM by Intel card?
>> And what is the purpose of sending type 1 VDM if it has to be 
>> discarded by root port anyway?
>
> I think you should really just disable the behavior at the root port.
> Which host driver are you using (sorry if I forgot and you already 
> mentioned it)?
>
>         Arnd
