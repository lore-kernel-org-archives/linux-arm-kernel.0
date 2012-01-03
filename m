From: j.kilb@phytec.de (=?ISO-8859-1?Q?J=FCrgen_Kilb?=)
Date: Tue, 03 Jan 2012 17:17:20 +0100
Subject: updating machine registry for 2843/pcaal1
Message-ID: <4F032A10.9030203@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've tried to fix the machine name of our product in the machine 
registry for machine number 2843.
The correct name is pcaal1. As you can see the machine name and the type 
macro are correct now.

Could you please update the Kconfig macro and the Type Identifier ?

is:
machine_is_pcaal1()
CONFIG_MACH_PCA102
MACH_TYPE_PCA102

should be:
machine_is_pcaal1()
CONFIG_MACH_PCAAL1
MACH_TYPE_PCAAL1

Thanks for your help.

greetings,
J?rgen
