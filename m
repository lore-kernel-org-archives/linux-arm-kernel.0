From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 23 May 2015 12:23:44 +0100
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
In-Reply-To: <555B78A3.2030202@metafoo.de>
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
 <1431038644-41600-2-git-send-email-xander.huff@ni.com>
 <555B78A3.2030202@metafoo.de>
Message-ID: <55606340.1090403@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/15 18:53, Lars-Peter Clausen wrote:
> On 05/08/2015 12:44 AM, Xander Huff wrote:
>> To better facilitate user-mode access to optional aux channels, allow
>> device trees to specify a custom extended name for defined channels.
> 
> Hi,
> 
> 'extend-name' is kind of a IIO specific term. I think a better name in the devicetree context would be 'label'. That's used everywhere else when giving a short description string to a node.
> 
Hi Lars,

What do you think of the general idea?  I'm unconvinced we want to do this in channel naming.
Perhaps we want an additional attribute giving access to this sort of 'semantic' information?
