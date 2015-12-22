From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Dec 2015 12:37:24 -0600
Subject: [RESEND PATCH v2 2/2] ASoC: atmel-classd: DT binding for PDMIC
 driver
In-Reply-To: <20151219113055.GF5727@sirena.org.uk>
References: <1450345800-21299-1-git-send-email-songjun.wu@atmel.com>
 <1450345800-21299-3-git-send-email-songjun.wu@atmel.com>
 <20151219040913.D0F442C02FD@rob-hp-laptop>
 <20151219113055.GF5727@sirena.org.uk>
Message-ID: <CAL_JsqKTNJ6Y0OUydkef3aYUO2jzDb30myvGJau-RBoJ3qe8hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 5:30 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Dec 18, 2015 at 01:56:21PM -0600, Rob Herring wrote:
>> On Thu, Dec 17, 2015 at 05:50:00PM +0800, Songjun Wu wrote:
>
>> > +- atmel,model
>> > +   The user-visible name of this sound card.
>> > +   The default value is "PDMIC".
>
>> When and why would this be different than the default?
>
>> "label" can be used here if this is really needed.
>
> The plastics for the system are often very important for audio
> configuration - we need userspace to be able to distinguish between
> systems that are identical even on the electrical level.

Okay. That is exactly what label is for, so please use it.

Rob
