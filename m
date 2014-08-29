From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 28 Aug 2014 21:09:24 -0700
Subject: use IORESOURCE_REG resource type for non-translatable addresses
 in DT
In-Reply-To: <53FE53E1.9030605@codeaurora.org>
References: <53D788A7.4020303@mm-sol.com> <3794875.CZFbAag5Sv@wuerfel>
 <53D7AA72.6010309@mm-sol.com>
 <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <53D84558.7060406@codeaurora.org>
 <CAL_JsqJjH0OH+X=fzwqAPeWarjoLev7v6Nv_QhAa+nZyztMnFA@mail.gmail.com>
 <20140730060619.GC19933@codeaurora.org>
 <CAJAp7OhoRQ1eWack1e=OL0cS4Fxmgxc7OWeNxcj1qt7Q-x-sQA@mail.gmail.com>
 <53FE53E1.9030605@codeaurora.org>
Message-ID: <CAJAp7Oj+3bUAciLcbfZpfDE0MFem8G_P1gTjV=-UK_U3o4UEZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 2:55 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> What's Josh's original proposal? We've already punted on this for SSBI
> PMICs and just required them to put registers in DT for use some day and
> I don't see anyone blocking individual SPMI pmic drivers from merging
> over this. So I guess I agree with you that we can move forward with the
> other drivers. I'd still like to see us make this better though, so it
> seems worthwhile to have the discussion and get to some conclusion.
>

That sounds totally reasonable, I agree that we should try to sort
this out and if we do this should be applicable on pm8xxx as well(?).

My concern was that further discussions would hinder the ability of
actually committing the pm8x41 container driver and that is in my eyes
blocking integration of drivers for the pmic blocks.

Regards,
Bjorn
