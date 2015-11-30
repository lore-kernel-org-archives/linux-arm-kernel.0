From: rsahu@apm.com (Rameshwar Sahu)
Date: Mon, 30 Nov 2015 14:27:34 +0530
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
In-Reply-To: <20151130085054.GA7928@gondor.apana.org.au>
References: <rsahu@apm.com> <1447665169-14003-1-git-send-email-rsahu@apm.com>
 <CAFd313zqimQtG8epeo3U7gzxWRf0hqO4K8hOFy4UK-6pG5GcJg@mail.gmail.com>
 <20151130083950.GA7792@gondor.apana.org.au>
 <CAFd313z2dncWmBQJY48RkReVOhQqLs13UzehwrbizBbputOSEw@mail.gmail.com>
 <20151130085054.GA7928@gondor.apana.org.au>
Message-ID: <CAFd313yfmA9eWUqTXuPb7w8L7RBLR0zHRqbaRKWkQqH9FUhyEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Mon, Nov 30, 2015 at 2:20 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Nov 30, 2015 at 02:19:33PM +0530, Rameshwar Sahu wrote:
>>
>> One of our client is using this layer for offloading the crc32c to our
>> dmaengine hw.
>
> Is this going to be merged into the kernel?
I am not sure about it, but as what I thought is Linux kernel supports
many algos in async mode and sync mode, later client has to take care
which one they are going to use.
Any way this offload implementation is specific to Applied Micro
X-Gene SoC, where we have such a dmaengine can do CRC32c.
>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
