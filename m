From: robherring2@gmail.com (Rob Herring)
Date: Tue, 1 Sep 2015 06:49:45 -0500
Subject: [PATCH v2 2/4] remoteproc: dt: Provide bindings for ST's Remote
 Processor Controller driver
In-Reply-To: <20150901104145.GS4796@x1>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-3-git-send-email-lee.jones@linaro.org>
 <CAL_JsqLuF2iAJhzjDh5CL-RgYk+H+N+D05wsWqUT01zvq9SOxA@mail.gmail.com>
 <20150901104145.GS4796@x1>
Message-ID: <CAL_JsqKJjs4-tewODq2R-vUT=Nr494emLvDA_GEC5xt=HJ3WoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2015 at 5:41 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 31 Aug 2015, Rob Herring wrote:
>
>> On Fri, Aug 28, 2015 at 5:31 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >  .../devicetree/bindings/remoteproc/st-rproc.txt    | 35 ++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
>> > new file mode 100644
>> > index 0000000..fbd7d78
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
>> > @@ -0,0 +1,35 @@
>> > +STMicroelectronics Remote Processor
>>
>> "remote processor" is what STM datasheets call them? This seems like
>> Linux naming is leaking in here.
>
> That's what this directory is called and the other binding within it.

That doesn't make it right or answer my question. Certainly our
directory structure too closely mirrors the kernel.

Rob
