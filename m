From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 30 Aug 2018 18:04:12 -0700
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
In-Reply-To: <20180831110054.475a3534@roar.ozlabs.ibm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
Message-ID: <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 6:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Well it would help if powerpc say wanted to start using them without a
> merge cycle lag. Not a huge issue because powerpc already does
> reasonably well here and there's other work that can be done.

Sure. If somebody wants to send the generic changes I can just take
them directly to make it easier for people to work on this.

               Linus
