From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Nov 2013 15:46:12 +0100
Subject: [PATCH] pinctrl: samsung: Allow grouping multiple pinmux/pinconf
 nodes
In-Reply-To: <7242109.um7KlGhuI2@amdc1227>
References: <1384881034-10520-1-git-send-email-t.figa@samsung.com>
 <528BB789.5020201@wwwdotorg.org> <7242109.um7KlGhuI2@amdc1227>
Message-ID: <CACRpkdZHUfZinS20OFm+DkziiACxDOvJNhDMvdw3LdDbau1tCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 3:00 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Stephen:
>> Is the lifetime of the string "returned" by
>> of_property_read_string_index() really so short that you must copy the
>> string? I'd be tempted just to store the pointer, although perhaps you
>> need to get() the node so that's safe.
>
> Right. I have done it the copy-less way in other places, but missed this
> one. Thanks.

So I guess I'm waiting for a new version of this patch, right?

Yours,
Linus Walleij
