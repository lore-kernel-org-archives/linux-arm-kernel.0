From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 18:36:24 +0100
Subject: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
In-Reply-To: <4F1696E4.9070806@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk>
 <4F1696E4.9070806@st.com>
Message-ID: <CACRpkdZrPKunfKOF0mqR-9DOZhCFAzwZHJ2gCZRjbC3TuqecvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 10:54 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Actually, dw_dmac is also doing the same, i.e. unmapping only for
> non-slave transfers.

Problem solved :-)

Yours,
Linus Walleij
