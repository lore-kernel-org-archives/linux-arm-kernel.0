From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 25 Aug 2013 15:29:17 +0100
Subject: [PATCH 2/3] KVM: ARM: Get rid of KVM_HPAGE_ defines
In-Reply-To: <20130825140529.GT8218@redhat.com>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
 <1376058613-26400-1-git-send-email-christoffer.dall@linaro.org>
 <20130825140529.GT8218@redhat.com>
Message-ID: <CAFEAcA9-hcGHYAKTP4xty1pB-bs=EgATrxKQhCOQ3YZOOpM4wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 August 2013 15:05, Gleb Natapov <gleb@redhat.com> wrote:
> (you will probably need them when you will implement
> nested HYP mode :)).

Smiley noted, but this is pretty unlikely since it's not possible
to lie to the guest about which mode it's in, so you can't make
a guest think it's in Hyp mode.

-- PMM
