From: jkridner@gmail.com (Jason Kridner)
Date: Tue, 3 Jan 2017 15:29:41 -0500
Subject: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
In-Reply-To: <20170103201103.GB25222@atomide.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CB5C8999-6CAE-41F6-85A6-D2A856BD8011@gmail.com>
 <20170103201103.GB25222@atomide.com>
Message-ID: <2D5ABB5A-E332-4D77-89EA-9DBF9A2FECFB@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Jan 3, 2017, at 3:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> * Jason Kridner <jkridner@gmail.com> [161228 13:27]:
>> 
>> 
>>> On Dec 27, 2016, at 11:58 AM, Robert Nelson <robertcnelson@gmail.com> wrote:
>>> 
>>> BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
>>> replaced by a TI wl1835 wireless module.
>>> 
>>> This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
>>> BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
>> 
>> I believe the correct statement is BWxx, but BWBx reserves the option to be software incompatible in some way. My preference is to have it boot anyway, but I believe that is only dependent in the bootloader. 
> 
> So does this patch need updating for that?

No, it is bootloader controlled. 

> 
> Regards,
> 
> Tony
