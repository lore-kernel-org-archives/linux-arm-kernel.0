From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 27 Feb 2014 10:38:32 -0300
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <20140225200447.GA1872@titan.lakedaemon.net>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
 <20140225151656.GI1010@titan.lakedaemon.net>
 <530CB725.5070904@gmail.com>
 <20140225154347.GJ1010@titan.lakedaemon.net>
 <530CEDB7.2070103@gmail.com>
 <20140225200447.GA1872@titan.lakedaemon.net>
Message-ID: <20140227133831.GA28443@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 03:04:47PM -0500, Jason Cooper wrote:
> On Tue, Feb 25, 2014 at 08:23:35PM +0100, Sebastian Hesselbarth wrote:
> > [Cooked down Cc list to relevant people and added Ezequiel who agreed
> > to test on Armada 375/38x.]
> > 
[..]
> 
> If you can drop the dtsi changes (I have them in mvebu/dt), and fix the
> whitespace change, then we can merge them as is.
> 

Tested for-next on Armada 375 and Armada 385 development boards. The
pinctrl debugfs looks correct.

I've been using for-next for a couple days now, without issues.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
