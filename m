From: vkoul@kernel.org (Vinod)
Date: Fri, 22 Jun 2018 10:18:20 +0530
Subject: [PATCH 2/2] hwrng: msm: add ACPI support
In-Reply-To: <30b28a05-dd63-603c-d4cd-296b84072faf@codeaurora.org>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <1529594276-12210-2-git-send-email-timur@codeaurora.org>
 <20180622042322.GF27187@vkoul-mobl>
 <869e9828-5e34-49db-4387-629dcc4b09b0@codeaurora.org>
 <20180622044417.GI27187@vkoul-mobl>
 <30b28a05-dd63-603c-d4cd-296b84072faf@codeaurora.org>
Message-ID: <20180622044819.GJ27187@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-06-18, 23:46, Timur Tabi wrote:
> On 6/21/18 11:44 PM, Vinod wrote:
> > So this make me think you should do 2 level support for ACPI, one ACPI
> > support and one V2 support where we dont touch CONFIG register. That way
> > both regions will work
> 
> The ACPI system is a v2 system.  If you want, I can just remove the read of
> the CONFIG register.

Okay, so in this case who configures v2. My guess here is that firmware
hasn't locked access, default everyone can access per spec

-- 
~Vinod
