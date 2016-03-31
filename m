From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 31 Mar 2016 13:13:16 +0200
Subject: Boot failure on i.MX6 boards due to commit 5e3ca2b349b1
 ("regulator: Try to resolve regulators supplies on registration")
In-Reply-To: <56FCFD84.6030508@nvidia.com>
References: <20160331122149.56281b0d@ipc1.ka-ro> <56FCFC9C.7080305@nvidia.com>
 <56FCFD84.6030508@nvidia.com>
Message-ID: <20160331131316.4d00a895@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 31 Mar 2016 11:35:48 +0100 Jon Hunter wrote:
> 
> 
> On 31/03/16 11:31, Jon Hunter wrote:
> > 
> > On 31/03/16 11:21, Lothar Wa?mann wrote:
> >> Hi,
> >>
> >> booting a TX6 module (i.MX6Q or i.MX6DL) fails with current linux-next.
> >> Bisecting revealed the culprit to be commit:
> >> 5e3ca2b349b1 (""regulator: Try to resolve regulators supplies on registration)
> >>
> >> Reverting this commit on top of next-20163031 makes the board functional again.
> > 
> > Can you try today's -next? I posted a fix for this yesterday which
> > should now be included [0].
> 
> Hmmm ... I see that you say you are testing today's -next. I tried and
> it is now working for me. Are you sure you are based upon next-20160331?
> 
Yes, next-20160331 works for me too without any patches.
Due to a stack corruption in a nested NMI of my workflow I had not
really tested next-20160331 before sending the mail.

Sorry for the noise,
Lothar Wa?mann
