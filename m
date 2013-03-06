From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 09:26:00 +0100
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <17540873.418471362551288113.JavaMail.weblogic@epml07>
References: <17540873.418471362551288113.JavaMail.weblogic@epml07>
Message-ID: <20130306092600.391f123c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jingoo Han,

On Wed, 06 Mar 2013 06:28:08 +0000 (GMT), Jingoo Han wrote:

> Sorry, I did not know that you submitted the patch.

No problem, I'm happy to have one less patch to carry in my PCIe patch
set :)

> Like you, I am developing PCIe Host driver.

Just curious, do you already have some code? Thierry Reding and myself
have been looking at each other's PCIe host driver since a while in
order to make some consistent choices where possible. It would be good
to see your code as well.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
