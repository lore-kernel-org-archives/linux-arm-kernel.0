From: xiaofeng.yan@huawei.com (xiaofeng.yan)
Date: Tue, 29 Apr 2014 10:17:13 +0800
Subject: mem-hotplug: Can arm receive memory-hotplug feature from x86 platform
Message-ID: <535F0BA9.5070309@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I found some scenario could need memory-hotplug feature in their product 
based on platform ARM.

  A typical scenario can be described as follows:
  Developer reserve some memory which can't be accessed by kernel and 
other function can use these memory before system start up.
After booting, system can reclaim the memory reserved with memory-hot 
plug mechanism. for example ,  user can add the reserved memory by the 
next command.
#echo "PHYSICAL_ADDRESS_OF_MEMORY, SIZE_FOR_ADDING_MEMORY" > 
/kernel/sys/addmemory/addmemory.

PHYSICAL_ADDRESS_OF_MEMORY: the begging position for adding memory
SIZE_FOR_ADDING_MEMORY: the memory size you want to add. the unit should 
be integral multiple of a section size.

So my question is whether arm support memory-hot plug or not in next 
plan. I am very interested to move the feature from x86 to arm.  I have 
finish the above function and realize dynamic memory addition.
I can push my patches if possible.
Give me your suggestion.

Thanks

xiaofeng.yan
