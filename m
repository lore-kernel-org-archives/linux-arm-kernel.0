From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 14:33:42 +0100
Subject: [PATCH 1/2] arm64: amd-seattle: Fix dma-ranges property
In-Reply-To: <1417405600-19232-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1417405600-19232-2-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <2316008.jChdsJ8v0y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 30 November 2014 21:46:39 suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> AMD Seattle should support 40-bit DMA.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 

The change looks good, but two things about the patch description:

- You should be a little more verbose, especially after we had discussed
  this to some detail on IRC, explain why you use the specific values.

- You should configure git-send-email to know your full email address
  including the name. Right now it gets sent from
  "suravee.suthikulpanit at amd.com" instead of "Suravee Suthikulpanit
  <Suravee.Suthikulpanit@amd.com>", and that causes the extra From
  line at the start of the mail, besides looking a bit strange.

Thanks,

	Arnd
