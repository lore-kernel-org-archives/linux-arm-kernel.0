From: bp@alien8.de (Borislav Petkov)
Date: Thu, 9 Jan 2014 12:03:59 +0100
Subject: [PATCH v4 3/6] ARM: Add Krait L2 accessor functions
In-Reply-To: <52CE0154.4030803@codeaurora.org>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
 <1388434457-4194-4-git-send-email-sboyd@codeaurora.org>
 <20140109005332.GB23276@sonymobile.com>
 <52CE0154.4030803@codeaurora.org>
Message-ID: <20140109110358.GB11594@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:54:28PM -0800, Stephen Boyd wrote:
> Ok. Borislav, should I resend to add krait_ before these functions?

Yes please - I can't even build-test here so I'm relying on you.

That's why I thought it might be a better idea for this purely arm patch
to go through some other tree where it sees some build-testing at least.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
