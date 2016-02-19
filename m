From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 19 Feb 2016 17:03:15 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <CAKv+Gu9GDE5MVLGkvx9NGB=R_AS--32aGYQ++zT9gGFwBFgnpw@mail.gmail.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <20160218180313.GE2538@e104818-lin.cambridge.arm.com>
 <CAFEAcA9SQjg3GpDpU-Tt8i+JiOcJWQKTNzwLLTC4imiBuiP6+w@mail.gmail.com>
 <20160219164606.GD12864@e104818-lin.cambridge.arm.com>
 <CAFEAcA_uAG1hX2a3n8FSJpB704wzJeXzijHSETJ2B6OR0g=nJw@mail.gmail.com>
 <CAKv+Gu9GDE5MVLGkvx9NGB=R_AS--32aGYQ++zT9gGFwBFgnpw@mail.gmail.com>
Message-ID: <CAFEAcA8V+wnD2JBRvsj+KvkjxHrcfa8jbb9CH3nJe-gjsxhKoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2016 at 16:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Doesn't this only affect TCG emulation, and not KVM?

Correct, but that's still a fair userbase.

thanks
-- PMM
