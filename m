From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 3 Sep 2009 15:30:32 +0800
Subject: [PATCH] Fix possibly uninitialized variable in PalmTC-pcmcia
In-Reply-To: <200909030443.29366.marek.vasut@gmail.com>
References: <200909030443.29366.marek.vasut@gmail.com>
Message-ID: <f17812d70909030030w1c11de46v63decff98cf33624@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2009 at 10:43 AM, Marek Vasut<marek.vasut@gmail.com> wrote:
> Hi!
>
> This 'problem' actually cant cause a failure of the driver, but it's always
> better to be correct.
>
> Eric, please consider applying. Thanks
>

Applied.
