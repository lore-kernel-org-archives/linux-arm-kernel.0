From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2012 16:16:11 +0100
Subject: [RFC] Add support for Aurora L2 Cache Controller
In-Reply-To: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAHkRjk4qPPktXsqnRaZLG0Z=VMH_Qf6xRdQBPMvxC20m6noc+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2012 16:05, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> - two flavors of the controller 'outer cache' and 'system cache' (the
>   last one meaning maintenance operations on L1 are broadcasted to the
>   L2 and L2 performs the same operation).

BTW, is the DSB also transparently handled by the L2 in 'system cache' mode?

-- 
Catalin
