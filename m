From: erik.oomen@zepcam.com (Erik Oomen)
Date: Thu, 17 Jun 2010 22:43:03 +0200
Subject: mxcmmc driver hangs on sync
In-Reply-To: <20100617195918.GN17833@buzzloop.caiaq.de>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
	<20100615152051.26e4589c@morgan>
	<20100615072237.GW17833@buzzloop.caiaq.de>
	<20100617163340.69409a3f@morgan>
	<45DEC573-1158-477E-A971-03CB4633F442@zepcam.com>
	<20100617195918.GN17833@buzzloop.caiaq.de>
Message-ID: <316135C6-8571-4B02-9268-52419AEAC56D@zepcam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> We've had the same problems for various kernels and mxcmmc modifications. The following fixed it.  We applied it to the 2.6.28 kernel and have been writing and reading *many* Gigabytes without a problem. 
> 
> Interesting. Did you try to push this back to mainline?
> 
> Daniel

No, at that time we where not sure this patch was a fix. Let's see if this solves Morgan's problems.

Erik.
