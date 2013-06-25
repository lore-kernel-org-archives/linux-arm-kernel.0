From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 25 Jun 2013 12:08:02 +0100
Subject: [STLinux Kernel] [PATCH v3 03/10] pinctrl:st: Add pinctrl and
 pinconf support.
In-Reply-To: <CACRpkdaxqfdXz8bE0coF_mN2W5EUW1ENUJqwV8ne-ezUBpziCA@mail.gmail.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
 <51C45816.5010207@st.com>
 <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
 <20130624141257.GM27646@sirena.org.uk>
 <CACRpkdaxqfdXz8bE0coF_mN2W5EUW1ENUJqwV8ne-ezUBpziCA@mail.gmail.com>
Message-ID: <51C97A12.3090608@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/13 11:58, Linus Walleij wrote:
> On Mon, Jun 24, 2013 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jun 24, 2013 at 01:57:56PM +0200, Linus Walleij wrote:
>>
>>> This seems fairly complete, but I cannot have such a basic dependency onto
>>> the regmap tree this late in the merge window, i.e. I'm not ready to pull
>>> all of regmap into the pinctrl tree. I'd consider this for merging
>>> for the next kernel cycle so it's more orthogonal.
>>
>> I've got the patch on a topic branch in regmap to allow for this sort of
>> stuff - I can readily provide a signed tag for you to get just that
>> patch if that'd help?  Alternatively I'm happy to carry the pinctrl
>> patch in regmap?
> 
> I'm OK that you carry this in the regmap tree.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks Linus W.

> 
> The clock retime weirdness convinced me that this cannot really
> use the generic pin config layout...
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
> 
