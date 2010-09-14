From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 14 Sep 2010 13:55:07 -0700
Subject: Importing RPC server bundle
In-Reply-To: <201009111516.34263.david.lanzendoerfer@o2s.ch>
References: <201009111516.34263.david.lanzendoerfer@o2s.ch>
Message-ID: <1284497707.31975.11.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-09-11 at 15:16 +0200, David Lanzend?rfer wrote:
> Hi
> I made finally USB gadget working by import the rpc server bundle from our
> fork[1] of the android kernel release 2.6.32.
> But GNUtoo asked me, why I imported such an old version, also of AMSS.
> So my question now to you folks:
> I can import it and make it work with a new version again,
> but I need to know, what source and place I shall take it from.
> 
> Thx in advance
> 	leviathan
> 
> [1] http://gitorious.org/htc-msm-2-6-32/leviathan-incoming/commits/msm-gnuconform


Usually we pull things from Google's tree, clean them up, then import
them potentially with some changes if needed. Is that what you mean?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
