From: clabbe@baylibre.com (LABBE Corentin)
Date: Mon, 10 Sep 2018 20:50:39 +0200
Subject: [PATCH 1/5] powerpc: rename setbits32/clrbits32 to
 setbits32_be/clrbits32_be
In-Reply-To: <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-2-git-send-email-clabbe@baylibre.com>
 <d16bf608-5b97-4baf-2ac1-a6d98656d716@c-s.fr>
Message-ID: <20180910185039.GB7819@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 07:16:56AM +0200, Christophe LEROY wrote:
> 
> 
> Le 07/09/2018 ? 21:41, Corentin Labbe a ?crit?:
> > Since setbits32/clrbits32 work on be32, it's better to remove ambiguity on
> > the used data type.
> 
> Wouldn't it be better to call them setbits_be32() / clrbits_be32() to 
> have something looking similar to in_be32() / ou_be32() ?
> 

I agree, I will update the patch.

Thanks
