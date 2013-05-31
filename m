From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 31 May 2013 00:03:35 -0400 (EDT)
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_A_bug_about_system_call_on_ARM?=
In-Reply-To: <ih0015wu30o5nq4ajf437rl7.1369916575726@email.android.com>
References: <ih0015wu30o5nq4ajf437rl7.1369916575726@email.android.com>
Message-ID: <alpine.LFD.2.03.1305302356140.30828@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Wang, Yalin wrote:

> Hi Will,
> 
> i see your solution,
> i Will test it tomorrow,
> and report the result to you ASAP!

This is good if you can report success without changing any of your 
current configuration.  This issue is worth fixing.

However, as others have mentioned already, you most likely can set 
CONFIG_OABI_COMPAT to n afterwards.  Not only will this make you immune 
to the bug you reported, but that will also make the syscall path more 
efficient as well.


Nicolas
