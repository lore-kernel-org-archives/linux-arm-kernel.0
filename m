From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 4 Apr 2014 04:24:27 -0700
Subject: The Alphabet (or, the sorting of Kconfig symbols)
In-Reply-To: <20140404111647.GZ7528@n2100.arm.linux.org.uk>
References: <20140404111647.GZ7528@n2100.arm.linux.org.uk>
Message-ID: <CACxGe6uoB6CkuV7HCg8wdyu2Tm471YaAz0sDA3W2C0MPAYYY+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 4, 2014 at 4:16 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> For those who don't know it, the order of letters in the alphabet is:
>
> A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
>
> and we use this order to determine the position of "select" entries in
> Kconfig files.  We do that so that we can reduce conflicts.  Conflicts
> such as these kinds of rubbish:

Equally applies to #include ordering.

g.
