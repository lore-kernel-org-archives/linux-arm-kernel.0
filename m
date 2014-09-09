From: bp@suse.de (Borislav Petkov)
Date: Tue, 9 Sep 2014 21:11:21 +0200
Subject: [PATCH 2/2] KVM: fix api documentation of KVM_GET_EMULATED_CPUID
In-Reply-To: <1410280039-2823-3-git-send-email-alex.bennee@linaro.org>
References: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
 <1410280039-2823-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <20140909191121.GB7072@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 05:27:19PM +0100, Alex Benn?e wrote:
> It looks like when this was initially merged it got accidentally included
> in the following section.

Whoops.

> I've just moved it back in the correct section
> and re-numbered it as other ioctls have been added since.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.
--
