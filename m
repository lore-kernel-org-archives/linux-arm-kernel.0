From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 14:18:14 +0000
Subject: [PATCH v3 0/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <20171027222353.56875-1-salyzyn@android.com>
References: <20171027222353.56875-1-salyzyn@android.com>
Message-ID: <20171030141813.nozm5bgumb5qp2ol@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 27, 2017 at 03:23:48PM -0700, Mark Salyzyn wrote:
> Note I noticed a bug in the old implementation of __kernel_clock_getres;
> it was checking only the lower 32bits of the pointer; this would work
> for most cases but could fail in a few.

Sorry if this is a stupid question, but do you mean from a prior version
of this series, or the one in the kernel today?

Thanks,
Mark.
