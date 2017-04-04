From: bp@alien8.de (Borislav Petkov)
Date: Tue, 4 Apr 2017 20:54:46 +0200
Subject: [PATCH v6 2/4] x86/syscalls: Specific usage of
 verify_pre_usermode_state
In-Reply-To: <05d9c4a7-8acb-5997-1dd6-d534398e6f54@zytor.com>
References: <20170404174727.35478-1-thgarnie@google.com>
 <20170404174727.35478-2-thgarnie@google.com>
 <05d9c4a7-8acb-5997-1dd6-d534398e6f54@zytor.com>
Message-ID: <20170404185446.7s5zwqn2bmw2cxid@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 11:27:07AM -0700, H. Peter Anvin wrote:
> Finally, I can't really believe I'm the only person for whom "Specific
> usage of verity_pre_usermode_state" is completely opaque.

No, you're not. I'm missing the usual layout of the commit message
"Problem is A, we need to do B, because of C." And this particular one
needs to be pretty verbose as it is tricky lowlevel, userspace return
blabla code and I'd prefer not to have to rhyme up together myself
what's going on and what we're fixing here.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
