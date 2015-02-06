From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Fri, 06 Feb 2015 10:01:34 +0100
Subject: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
In-Reply-To: <54D423C3.9030105@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org>
 <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6>
 <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum>
 <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org>
 <54D3900A.9060200@gmail.com> <54D423C3.9030105@codeaurora.org>
Message-ID: <54D482EE.6050004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/02/2015 03:15, Stephen Boyd wrote:
> Thanks for the coccinelle patch. Thinking more about it, I don't think
> we care if the pointer is dereferenced because that would require a
> definition of struct clk and that is most likely not the case outside of
> the clock framework. Did you scan the entire kernel?
No I haven't.
> I'm running it now
> but it seems to be taking a while.
>
Yes, that's why, as a first step, I chose to limit the scan to the arm 
directory.
