From: w.mohanrao@gmail.com (Mohan Wankhede)
Date: Sat, 2 Jan 2010 21:49:29 +0530
Subject: Mach-Id query
In-Reply-To: <01895E84-95EF-4312-BF54-F393CF54FBE8@gmail.com>
References: <01895E84-95EF-4312-BF54-F393CF54FBE8@gmail.com>
Message-ID: <9A51DF0E91794D168FCE95076C3310A3@VIJAYRAOdc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soumendra,

You can do it as well.

Open the file arch/arm/kconfig in vi editor

Add configuration variables and defines for your platform to this file. Take
the reference of the other platform defined in the files.

Then add the machines specific rules if any to arch/arm/kconfig.

Once this is done you can create the configuration and save this as default
configuration.

For further information refer to the help files in
/kernel/Documentation/kbuild 

I hope this will help.

 

Thanks and Regards

Mohan Rao

 

  _____  

From: linux-arm-kernel-bounces@lists.infradead.org
[mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
soumendra.satapathy at gmail.com
Sent: Tuesday, December 29, 2009 11:56 PM
To: linux-arm-kernel at lists.infradead.org
Subject: Mach-Id query

 

Dear All, 

 

I am working a proprietary ARM development board.

 

I have registered the machine ID for this @ <http://www.arm.linux.org.uk/>
www.arm.linux.org.uk

 

Now i addded this to mach-types file in arm/tools/mach-types file.

 

Now before compiling i need to have the defualt config file which is 

 

found in the directory arch/arm/configs for variuos boards.

 

How are these genarated for lets say omap_2430sdp_defconfig (this is a
automatically generated file is what i can see) ??

 

All replies are humbly appreciated. 

 

regards,

som 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100102/37f9ba9c/attachment-0001.htm>
