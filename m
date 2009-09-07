From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Sep 2009 00:08:13 +0800
Subject: zaurus c3000 aka spitz: fix resume
In-Reply-To: <1252243938.4136.26.camel@utx.utx.cz>
References: <20090906052840.GF1324@ucw.cz>
	<1252243938.4136.26.camel@utx.utx.cz>
Message-ID: <f17812d70909070908l26541562iec36a117c155aa08@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 6, 2009 at 9:32 PM, Stanislav Brabec<utx@penguin.cz> wrote:
> Pavel Machek wrote:
>> sharpsl_pm.c code tries to read battery state very early during
>> resume, but those battery meters are connected on SPI and that's only
>> resumed way later.
>>
>> Replace the check with simple checking of battery fatal signal, that
>> actually works at this stage.
>
> Tested on:

Applied to 'fix'.
