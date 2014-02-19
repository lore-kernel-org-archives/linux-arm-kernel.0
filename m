From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Feb 2014 15:23:36 +0000
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140219150654.GH10134@htj.dyndns.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
 <20140219140458.GA10134@htj.dyndns.org>
 <20140219150121.GG10504@lee--X1>
 <20140219150654.GH10134@htj.dyndns.org>
Message-ID: <20140219152336.GH10504@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I think that's a pretty unfair ask. I could understand if the
> > patch(es) didn't apply, or were hindered by the new API change, but I
> > do not believe that is the case?
> 
> Let me make it very clear to you.  If you want your code in, you help
> maintaining the larger code base.  I'm already extremely annoyed about
> the general behavior of embedded developers where the general attitude
> seems to be doing whatever to get *my* driver in the tree.  So, fuck
> you a little bit and if you want to make it happen faster, help Hans'
> patchset mature.  Unfair my ass.

Since when has maintaining core code been the responsibility of the
leaf driver developers? If you're aware that the core code is
sub-standard then it's you who should be fixing it.

I think it's great that forward thinking developers like Hans take on
challenges to improve subsystems which are lacking in one way or
another, but holding back other development while this process is
ongoing is fundamentally wrong. Especially in this case where you're
still actively reviewing/NACKing the core changes.

Changes to APIs should either support backward-capability or change all
effected drivers. I haven't been able to apply the patches yet, so I
can't tell which one of these holds true, but I believe it's the
former. In which case any new driver using the _current_ (not old)
API should fold neatly in. I've even offered to convert to the new API
once it's Mainlined. How can I say fairer than that?

Finally, do try and stay at least a little bit professional on the
MLs. That sort of disrespectful, rude behaviour may be how you guys do
it at Redhat, but most will think it's nothing more than childish.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
