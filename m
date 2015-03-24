From: samitolvanen@google.com (Sami Tolvanen)
Date: Tue, 24 Mar 2015 18:17:59 +0000
Subject: [PATCHv2] arm: crypto: Add optimized SHA-256/224
In-Reply-To: <CAKv+Gu-LL5JzALPqPnxdVqQ7HUwnJZQ3=GzPk_h1KSUJp2SVAw@mail.gmail.com>
References: <20150316154835.GA31336@google.com>
 <20150323135009.GB820@google.com>
 <20150324122702.GJ14457@ns203013.ovh.net>
 <CAKv+Gu-j8m7NAYHL8swjwJ0as6TzNyjqhk0Tp1QhDhH=E78K3Q@mail.gmail.com>
 <20150324130511.GK14457@ns203013.ovh.net>
 <CAKv+Gu8Px6dYKdrVFyh_5WN3sEAGYy0fv0qHONJ5x+68YZjCOQ@mail.gmail.com>
 <CAKv+Gu_4G69JZJPex_=1xOZ4z5Fxtht4YG4G=TnYrkXPuiXvFg@mail.gmail.com>
 <20150324170543.GL14457@ns203013.ovh.net>
 <CAKv+Gu-LL5JzALPqPnxdVqQ7HUwnJZQ3=GzPk_h1KSUJp2SVAw@mail.gmail.com>
Message-ID: <20150324181759.GA2156@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 06:40:29PM +0100, Ard Biesheuvel wrote:
> @Sami, Andy: we need to respin the whole patch, including updated
> OpenSSL upstream commit id :-(

Sure, I will send v3 once the changes are in OpenSSL. Thanks for testing!
Do you still prefer everything in one patch?

Sami
