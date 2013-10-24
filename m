From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 24 Oct 2013 17:00:16 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024083411.GH9403@ulmo.nvidia.com>
References: <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023174736.GD5208@netboy>
 <20131023180240.GA32563@obsidianresearch.com>
 <20131023182345.GG5208@netboy>
 <20131024083411.GH9403@ulmo.nvidia.com>
Message-ID: <20131024150016.GB4096@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:34:12AM +0200, Thierry Reding wrote:
> 
> There's another thing with DT bindings that makes them needlessly hard
> to settle on. Let's say you come up with a binding that accurately
> describes the hardware at hand and has been proven to work. Now people
> keep telling you that it might not be good enough, for whatever reason
> so eventually you decide to be bold and tell them that you're aware of
> everything that stable DT bindings imply and that there might be some
> risk of having to maintain two bindings because the first one didn't
> turn out to be perfect and yada yada.

You make a good point here. In my own limited experiences with DT
kernel development, a big debate always emerged about exactly how
these bindings should be called. Not being a real DT expert myself, I
really couldn't understand what the point was, but I just implemented
what the DT people wanted (or just dropped the submission altogether,
in one case).

I think the frustration that you have experienced is simply a result
of the attitude on the DT list. Maybe the real issue is attitude
and personalities, and not the hurdle of stable bindings.

Thanks,
Richard
