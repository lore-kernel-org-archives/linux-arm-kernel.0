From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 18 Apr 2012 12:08:09 -0400
Subject: irq_domain_generate_simple()
Message-ID: <CAKON4OzLSHEWjcq0t2jdUgB6qmqcy=Wj=ENbvbMZiTqW_ZNicQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of the asserts in irq_domain_add_legacy() mean
irq_domain_generate_simple() can't use a fixed size of 32. It needs a
parameter to pass in the size. I switched to calling
irq_domain_add_legacy() directly.

-- 
Jon Smirl
jonsmirl at gmail.com
