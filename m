From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 30 Jul 2014 11:01:23 +0200
Subject: [RFC 1/5] regulator: core: Get voltage from parent if not
 available
In-Reply-To: <20140729182601.GA17528@sirena.org.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140729182601.GA17528@sirena.org.uk>
Message-ID: <53D8B463.5060405@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2014 08:26 PM, Mark Brown wrote:
> On Tue, Jul 29, 2014 at 06:28:55PM +0200, Javier Martinez Canillas wrote:
>> Load switches are modeled as regulators but they just provide
>> the voltage of their parent input supply. So the drivers for
> 
> Applied, thanks.  The term "load switch" is a bit unusual - they're
> usually just called switches (or sometimes FETs since that tends to be
> the implementation).
> 

Thanks, I used the terminology from the tps65090 data manual [0] that refers
these components as "load switches" all around the document. Although they are
called FETs indeed in the tables and register names.

Best regards,
Javier

[0]: http://www.ti.com/lit/gpn/tps65090
