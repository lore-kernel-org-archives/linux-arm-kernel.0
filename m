From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 17:26:13 +0000
Subject: [PATCH v2 2/2] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20160202181949.d59e84a040a980abcdd69d32@free.fr>
References: <cover.1452876522.git.moinejf@free.fr>
 <4c40052b27f74df1342e631cb0f9ed5993861a54.1452876522.git.moinejf@free.fr>
 <569F6C1E.8000006@arm.com> <20160202181949.d59e84a040a980abcdd69d32@free.fr>
Message-ID: <56B0E6B5.5040708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 17:19, Jean-Francois Moine wrote:
> On Wed, 20 Jan 2016 11:14:38 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> I haven't looked at it in detail yet, I just tried to compile it for
>> ARM64 to prepare for a test on the Allwinner A64.
>>
>> So just two things I spotted below:
> 
> Hi Andr?,
> 
> I fixed them in the v3 patch request.

Thanks for that.

> Have you succeeded to get video on the A64?

No, but I haven't tried yet. I am tempted to give it a go, though. I
guess this "headless Linux" term has scared some backers, who had more
associations with Sleepy Hollow than with a serial terminal ;-)

Can you sketch (or point me to) what I need to do? Just a
simple-framebuffer DT node?
I take it that the driver does not depend on any kind of U-Boot
initialisation, but instead takes care of this itself?

And would this pave the way for fbturbo also?

Please excuse my probably silly questions, I am more of a headless
horseman ;-)

Cheers,
Andre.
