From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 11:29:32 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731152523.GW9858@sirena.org.uk>
References: <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
 <20130731115027.GN9858@sirena.org.uk>
 <20130731115527.GR2810@htj.dyndns.org>
 <20130731132708.GQ9858@sirena.org.uk>
 <20130731134215.GS2810@htj.dyndns.org>
 <20130731135751.GT9858@sirena.org.uk>
 <20130731140758.GT2810@htj.dyndns.org>
 <20130731152523.GW9858@sirena.org.uk>
Message-ID: <20130731152932.GV2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 04:25:23PM +0100, Mark Brown wrote:
> What I'm saying is that in essentially all the users I've seen devm is
> only being used for things like kfree() or clk_put() which aren't really
> connected in any way and can happen in any order.  This (coupled with
> the lack of documentation that this is supported) is why people are
> nervous about anything that relies on ordering with this stuff - aside
> from ATA everything is just using this for straight frees.

Yeah, sure, thank you very much for your input.  It is of course
strictly ordered and the documentation needs to be updated.

-- 
tejun
