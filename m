From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 7 Mar 2016 12:19:34 +0000
Subject: linux-next: manual merge of the watchdog tree with the arm-soc
 tree
In-Reply-To: <CAOesGMjD51rNqd3V8BE6xHkYZQdB8nc_Azppk1U+m8GwrtUv6w@mail.gmail.com>
References: <20160307150402.191ba735@canb.auug.org.au>
 <CAOesGMjD51rNqd3V8BE6xHkYZQdB8nc_Azppk1U+m8GwrtUv6w@mail.gmail.com>
Message-ID: <56DD71D6.8040406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 07/03/16 05:41, Olof Johansson wrote:
> Hi Wim,
>
> It's much easier for us if all DTS changes go in through the arm-soc
> trees, to avoid these kind of conflicts. Is this on a branch where you
> can easily drop it and we pick it up instead, or is it on a now-stable
> branch?
>

Sorry for that. Since the patch series was still under discussion and
v14 was posted 3 days ago, I had not checked with Fu Wei on his plans
for DTS changes.

Let me know if you want to pick up this single patch directly or want me
to send PR for that if Wim drops it from his branch. I might have couple
of DTS warning fixes for juno/vexpress(though I need to wait for Rob's
acks to them), so I can bundle them together.

-- 
Regards,
Sudeep
