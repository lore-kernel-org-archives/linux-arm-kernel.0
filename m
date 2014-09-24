From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 Sep 2014 18:41:33 +0200
Subject: [PATCH 1/9] ARM: dts: vf610: Add system reset controller (SRC)
In-Reply-To: <CACRpkdbryJVW9e9N5+f3rWEGZ2YvLPJsvBtNSa9nPJpLVXhm0g@mail.gmail.com>
References: <cover.1411404079.git.stefan@agner.ch>
 <2ca1cf3732a00512fa19b6118f9fb30aba014deb.1411404079.git.stefan@agner.ch>
 <CACRpkdbryJVW9e9N5+f3rWEGZ2YvLPJsvBtNSa9nPJpLVXhm0g@mail.gmail.com>
Message-ID: <45f7af8b2dbe11967bb2ad87826b934c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-24 11:16, schrieb Linus Walleij:
> On Mon, Sep 22, 2014 at 7:09 PM, Stefan Agner <stefan@agner.ch> wrote:
> 
>> Add device tree property for system reset controller.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Are there already device tree bindings for SRC and GRC?

Yes there are used in the i.MX6 world for instance, see imx6qdl.dtsi.
The SRC also has quite generic documentation, however, the GPC module
currently lacks documentation...

--
Stefan
