From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 May 2011 14:42:38 -0400 (EDT)
Subject: [git pull] ARM Device tree support
In-Reply-To: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
References: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105241435550.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 May 2011, Grant Likely wrote:

> Hi Russell,
> 
> How do you want to handle merging the ARM DT support?  Do you want to
> pull it into your tree, or would you like me to ask Linus to pull
> directly?  As you can see, It does include a couple of pre-requisite
> cross-arch cleanups that I normally push to Linus directly.

I don't think that Linus would object to you pushing that to him 
directly, given that Russell has already agreed to those patches going 
in this cycle.

Whatever the path, it is however important that they do get in _this_ 
cycle.  Most people are just too nervous committing themselves to DT if 
the basic stuff doesn't hit mainline.  And if we are serious about 
_trying_ to change the state of things in ARM land by going the DT route 
then we must have this in mainline as soon as possible.


Nicolas
