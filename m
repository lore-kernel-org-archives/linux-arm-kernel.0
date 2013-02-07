From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 7 Feb 2013 15:37:13 +0100
Subject: kernel 3.8 make problem [solved]
In-Reply-To: <20130207110345.GC15387@mudshark.cambridge.arm.com>
References: <ttxj4oytvg02pxivwnruketi.1359554350723@email.android.com>
 <20130130150729.4aae5409@armhf> <51093541.3020309@openwrt.org>
 <20130206180305.3bbc2d4d@armhf>
 <20130206170638.GJ17833@n2100.arm.linux.org.uk>
 <20130207111206.153df673@armhf>
 <20130207110345.GC15387@mudshark.cambridge.arm.com>
Message-ID: <20130207153713.15e4b530@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Feb 2013 11:03:46 +0000
Will Deacon <will.deacon@arm.com> wrote:

> > What is the devil with make?  
> 
> It uses bottom-up mmap (guessing it changes the stack rlimit) which is
> currently broken with 2:2 split. There's a fix queued in rmk's tree
> [dcef4c760f ("ARM: 7638/1: memory: define TASK_UNMAPPED_BASE in terms of
> TASK_SIZE")].

Thank you very much. 'make' works fine now.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
