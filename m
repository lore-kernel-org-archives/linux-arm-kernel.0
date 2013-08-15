From: zonque@gmail.com (Daniel Mack)
Date: Thu, 15 Aug 2013 12:51:31 +0200
Subject: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <20130815103358.GY2401@sirena.org.uk>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk>
Message-ID: <520CB2B3.9050804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.08.2013 12:33, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 10:42:38AM +0200, Daniel Mack wrote:
>> The pxa ssp DAI acts as a user of a pxa ssp port, and needs an
>> appropriate 'port' phandle in DT to reference the upstream.
> 
> I've applied this and the rest of the series though I'm not really that
> happy about having a binding for the DAI in the DT since there's at best
> tenouous hardware there.
> 

Hmm, and you don't like the approach either of having upstream ports and
assign users to it via phandles?

Also note that the last patch in that series ("ASoC: pxa: add DT
bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
to care for a proper solution at some point.


Daniel
