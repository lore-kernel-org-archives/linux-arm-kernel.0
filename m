From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 15 Aug 2013 09:51:22 +0100
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <20130814204302.GA8837@cbox>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <CAL_Jsq+vGd7+pw6YX0YNHO5rVSoiHCHbtXXdZ-3grnEcAOc38Q@mail.gmail.com>
 <520BE673.9010801@calxeda.com> <20130814204302.GA8837@cbox>
Message-ID: <CAFEAcA_+8cNtTKPj=FiKL3CukrUGCAKnjoepLkHHKhVBXM95fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 21:43, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> Agreed, but we need a more generic solution for the secure call
> handling.  I've created a backlog item in Linaro's JIRA (CARD-801) for
> this work, let's see how quickly we can get it approved and put on the
> roadmap.

FYI, here's my sketch from last year of what I had in mind:
http://lists.gnu.org/archive/html/qemu-devel/2012-05/msg03012.html

-- PMM
