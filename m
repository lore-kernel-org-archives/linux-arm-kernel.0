From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 26 Jun 2013 14:54:17 +0100
Subject: [PATCH 3/4] arm: Add [U]EFI runtime services support
In-Reply-To: <CACxGe6sH4dAVryBp7TeUmrwsJmnMdLsQm++U4EVDJVNi9pnqYw@mail.gmail.com>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-4-git-send-email-leif.lindholm@linaro.org>
 <CACxGe6sH4dAVryBp7TeUmrwsJmnMdLsQm++U4EVDJVNi9pnqYw@mail.gmail.com>
Message-ID: <20130626135417.GP22026@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jun, at 02:46:09PM, Grant Likely wrote:
> Eventually we'll need to look at how this interacts with kexec. A
> kexec'd kernel will need to use the mapping already chosen by a
> previous kernel, but that's an issue for another patch series.

FYI, this is exactly what Borislav has been tackling on x86 recently. It
would be nice if we could find one scheme that suits everyone.

-- 
Matt Fleming, Intel Open Source Technology Center
