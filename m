From: qiyaoltc@gmail.com (Yao Qi)
Date: Wed, 30 Nov 2016 09:56:14 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAH=s-POegNL2HLV3EGPt=b-jrJ4OOwpBFTfysMaX0TNgSw=3Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Dave,

On Fri, Nov 25, 2016 at 7:38 PM, Dave Martin <Dave.Martin@arm.com> wrote:
>  * No independent SVE vector length configuration per thread.  This is
>    planned, but will follow as a separate add-on series.

If I read "independent SVE vector length configuration per thread"
correctly, SVE vector length can be different in each thread, so the
size of vector registers is different too.  In GDB, we describe registers
by "target description" which is per process, not per thread.

-- 
Yao (??)
