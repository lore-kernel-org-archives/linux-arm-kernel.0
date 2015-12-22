From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 22 Dec 2015 15:58:32 -0800
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <7h60zqund8.fsf@deeprootsystems.com> (Kevin Hilman's message of
 "Tue, 22 Dec 2015 14:31:15 -0800")
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com> <5679B15F.80106@free.fr>
 <7hoadi6wfw.fsf@deeprootsystems.com> <5679C743.1070000@free.fr>
 <7h60zqund8.fsf@deeprootsystems.com>
Message-ID: <7hy4cmrq6v.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@kernel.org> writes:

> Mason <slash.tmp@free.fr> writes:

[...]

>>
>> Can I submit the defconfig update as a follow-up patch?
>
> IMO, it should be part of this series that adds the platform.  That way,
> as soon as it gets merged, it will be automatically build tested by
> various automated builders.  (also note that it would be automatically
> boot tested if I had the hardware as well... hint, hint) ;)

Olof's and my emails crossed paths, so the main part of the series is
already merged.

Please send a defconfig patch which we can apply to next/defconfig and
so it gets some build test coverage.

Thanks,

Kevin
