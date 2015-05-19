From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 19 May 2015 19:53:39 +0200
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,extend-name as an
 optional argument for aux channels
In-Reply-To: <1431038644-41600-2-git-send-email-xander.huff@ni.com>
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
 <1431038644-41600-2-git-send-email-xander.huff@ni.com>
Message-ID: <555B78A3.2030202@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 12:44 AM, Xander Huff wrote:
> To better facilitate user-mode access to optional aux channels, allow
> device trees to specify a custom extended name for defined channels.

Hi,

'extend-name' is kind of a IIO specific term. I think a better name in the 
devicetree context would be 'label'. That's used everywhere else when giving 
a short description string to a node.

- Lars
