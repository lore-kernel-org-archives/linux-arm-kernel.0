From: alex.popov@linux.com (Alexander Popov)
Date: Wed, 21 Feb 2018 17:48:28 +0300
Subject: [PATCH 0/2] Stackleak for arm64
In-Reply-To: <20180221011303.20392-1-labbott@redhat.com>
References: <20180221011303.20392-1-labbott@redhat.com>
Message-ID: <ee58357e-4c98-ec67-60de-0f8283261727@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.02.2018 04:13, Laura Abbott wrote:
> This is the arm64 version of the STACKLEAK plugin originall from
> grsecurity. See
> https://marc.info/?l=kernel-hardening&m=151880470609808 for the
> full x86 version. This is based on top of Kees' branch for stackleak
> and has been cleaned up to use a few macros from that branch.
> 
> Comments welcome, if there are no major objections Kees will queue this
> up to get some CI testing. This passed both of the LKDTM tests.

Hello, Laura,

Thank you. I'll take some time to learn your patches and test them on my LeMaker
HiKey board. I'll return with the feedback.

Best regards,
Alexander
